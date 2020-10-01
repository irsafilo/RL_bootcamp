# Baseline

0) Выполним на виртуальной машине следующие команды для начала работы с моделью
```
cd football
source football-env/bin/activate
Xvfb :1 -screen 0 1280x720x24+32 -fbdir /var/tmp &
export DISPLAY=:1
```
1) Сделаем модель с новой архитектурой cnn_small.


Архитектура cnn_small:
```
@register("cnn_small")
def cnn_small(**conv_kwargs):
    def network_fn(X):
        h = tf.cast(X, tf.float32) / 255.

        activ = tf.nn.relu
        h = activ(conv(h, 'c1', nf=8, rf=8, stride=4, init_scale=np.sqrt(2), **conv_kwargs))
        h = activ(conv(h, 'c2', nf=16, rf=4, stride=2, init_scale=np.sqrt(2), **conv_kwargs))
        h = conv_to_fc(h)
        h = activ(fc(h, 'fc1', nh=128, init_scale=np.sqrt(2)))
        return h
    return network_fn
```
Зарегистрируем ее в файлик /football/gfootball/examples/models.py .
Также добавим в файлик строчки загрузки необходимых библиотек.
```
from baselines.a2c.utils import conv, fc, conv_to_fc, batch_to_seq, seq_to_batch
```
Добавим нашу модель в файлик /football/gfootball/examples/run_ppo2.py .

```
flags.DEFINE_enum('policy', 'cnn', ['cnn', 'lstm', 'mlp', 'impala_cnn',
                                    'gfootball_impala_cnn', 'cnn_small']
                  'Policy architecture')
```
2) Обучим модель с нашей архитектурой и наградой 'scoring,chekpoints'.
Добавим параметр --dump_scores 2>&1 для сохранения dump-ов обучения.
Также будем логировать все в файлик repro_checkpoint_easy.txt.
Важно: запускать обучения нужно из директории football.
```
python3 -u -m gfootball.examples.run_ppo2   --level 11_vs_11_easy_stochastic   --reward_experiment scoring,checkpoints   --policy cnn_small   --cliprange 0.115   --gamma 0.997   --ent_coef 0.00155   --num_timesteps 100000   --max_grad_norm 0.76   --lr 0.00011879   --num_envs 16   --noptepochs 2   --nminibatches 4   --nsteps 512   "$@"  --dump_scores 2>&1 | tee small_repro_checkpoint_easy.txt .
```
В процессе обучения будет выводиться таблица с прогрессом.
После каждых n шагов модель будет сохраняться в эту директорию.

3) Посмотрим, как наша модель научилась играть.

Для этого также в директории football запустим play_game.

```
python3 -m gfootball.play_game --players "ppo2_cnn:left_players=1,policy=cnn_small,checkpoint=/tmp/openai-2020-09-30-20-57-08-906834/checkpoints/00001;ppo2_cnn:right_players=1,policy=cnn_small,checkpoint=/tmp/openai-2020-09-30-20-57-08-906834/checkpoints/00001"
```



