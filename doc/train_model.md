# Режимы обучения модели

1) Обучение со стандартными архитектурами.

В рамках стратегии PPO2 (https://openai.com/blog/openai-baselines-ppo/#ppo)
можно обучать модель с разными архитектурами - *cnn, impala_cnn, mlp, lstm, gfotball_impala_cnn*.
Этот список можно передать тэком для параметра модели. Имя архитектуры можно передать в параметре ```--policy```.
О других архитектурах можно почитать в ссылке про архитектуры.
https://github.com/openai/baselines/blob/master/baselines/common/models.py
```
python3 -u -m gfootball.examples.run_ppo2 \
  --level 11_vs_11_easy_stochastic \
  --reward_experiment scoring \
  --policy impala_cnn
```
2) Обучение со своей архитектурой.

Также можно обучать модели со своей архитектурой. Для этого на виртульной машине нужно изменить файлик
```/football/gfootball/examples/models.py``` и зарегистрировать свою архитектуру.

Пример:
```
@register('my_impala_cnn')
def my_impala_cnn():
```
Также нужно изменить файлик ```/football/gfootball/examples/run_ppo2.py```
В строчке, приведенный ниже, нужно добавить имя своей архитектуры.
```
flags.DEFINE_enum('policy', 'cnn', ['cnn', 'lstm', 'mlp', 'impala_cnn',
                                    'gfootball_impala_cnn', 'my_gfootball_impala_cnn'],
                  'Policy architecture')

```
3) Параметры модели.

Можно изменять параметры модели. Поподробнее прочитать про них можно здесь:
https://github.com/openai/baselines/tree/master/baselines/ppo2
Пример запуска:
```
 python3 -u -m gfootball.examples.run_ppo2 \
  --level 11_vs_11_easy_stochastic \
  --reward_experiment scoring \
  --policy impala_cnn \
  --cliprange 0.115 \
  --gamma 0.997 \
  --ent_coef 0.00155 \
  --num_timesteps 50000 \
  --max_grad_norm 0.76 \
  --lr 0.00011879 \
  --num_envs 16 \
  --noptepochs 2 \
  --nminibatches 4 \
  --nsteps 512 \
  "$@" --dump_scores 2>&1 | tee repro_checkpoint_easy.txt
  ```
  ```"$@" --dump_scores 2>&1 | tee repro_checkpoint_easy.txt``` - сохранение дампов обучения и логирования обучения в файлик 
  repro_checkpoint_easy.txt
  ```--reward``` - функция вознаграждения. 'SCORING' и 'CHEKPOINTS'.
  'SCORING' - команда получает награду +1 при забивании гола и награду −1 при уступке одной команды противоположной команде. 
  CHECKPOINTS - это награда , предназначенная для решения проблемы разреженности SCORING. Подсчету очков помогает продвижение
  на поле: увеличиваем награду за перемещение мяча близко к цели противника.
  Подробнее про параметры и архитектуры можно почитать в документа с литературой - https://github.com/irsafilo/RL_bootcamp/blob/master/doc/advices.md
  
4) Дообучение модели.

Для дообучения модели нужно использовать параметр ```--load_path```, который
указывает путь к уже обученной модели.

5) Обучение против противника.

Также есть возможность обучать модель в среде против противника.
Для этого в файлик ```/football/gfootball/examples/run_ppo2.py``` в функции create_single_football_env
надо добавить  параметр ```--extra_players```.

Пример:
```
def create_single_football_env(iprocess):
  """Creates gfootball environment."""
  print('create')
  env = football_env.create_environment(..., extra_players=['ppo2_cnn:right_players=1,policy=cnn,checkpoint=$path_to_model'])
```


 
