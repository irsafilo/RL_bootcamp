# Инструкция запуска на виртуальной машине

1) Скачать start.sh
2) Выполнить 
  ```sh start.sh```
Будет происходить загрузка необходимых библиотек. Время выполнения ~ 2 часа.
Затем нужно будет перейти в директории football, которая будет создана после запуска предыдущего скрипта,
и активировать окружение следующими командами.
  ```
  cd football
  source football-env/bin/activate
  ```
3) Проверка обучения
Пример того как, можно обучать модель в рамках policy PPO2. Нужно проверить правильно ли, все поставилось.
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
 Если все выполнено правильно, то появиться таблица с процессом обучения
 Модель сохранятеся после каждых n шагов в папку 
/tmp/openai-{дата-время}/checkpoints/{шаг}

После обучения давайте попробуем поиграть с нашей моделью.

4) Попробовать запустить игру можно так
- наша модель против нашей же модели
```
python3 -m gfootball.play_game --players 
"ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/0*;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг}"
```
- наша модель против гугловской
```
python3 -m gfootball.play_game --players "ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг};ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-date/checkpoints/11_vs_11_easy_stochastic_v2"
```
Гугловскую модель можно скачать с репозитория https://github.com/google-research/football

- игра против модели с клавиатуры
```
python3 -m gfootball.play_game --players 
"keyboard:left_players=1;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг}"
```
Все команды нужно запускать, находясь в директории ```/football/```.

5) Как сделать свою архитектуру?
```/football/gfootball/examples/models.py``` - это файлик для регистрации моделей в рамках PPO2.
Пример **gfootball_impala_cnn, my_gfootball_impala_cnn**.
Здесь можно менять архитектуры и регистрировать их.
Также в файлике ```/football/gfootball/examples/run_ppo2.py```
в строчке ```flags.DEFINE_enum('policy', ...)``` 
надо добавить название своей архитектуры модели
 
# Инструкция запуска на ноуте (linux + видеокарта)

1) Скачать start_nt.sh
2) Выполнить 
  ```sudo bash start.sh```
Будет происходить загрузка необходимых библиотек. Время выполнения ~ 2 часа.
Затем нужно будет перейти в директории football, которая будет создана после запуска предыдущего скрипта,
и активировать окружение следующими командами.
  ```
  cd football
  source football-env/bin/activate
  ```
При ошибке с absl либой доставить :
  ```sudo pip3 install absl-py```
  
 3) Проверка рендеринга игры
 
 ```
 MESA_GL_VERSION_OVERRIDE=3.2 MESA_GLSL_VERSION_OVERRIDE=150
 python3 -m gfootball.play_game --action_set=full
 ```
 




