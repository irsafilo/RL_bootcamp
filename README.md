# Инструкция запуска на виртуальной машине


1) Запустить sudo start.sh

```cd football
source football-env/bin/activate
```
******************
Пример обучения моделей
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
 
 Модель сохранятеся на каждые n шагов в папку 
/tmp/openai-date/checkpoints/0*
*********************************
Попробовать запустить игру можно так
наша модель против нашей модели
python3 -m gfootball.play_game --players "ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/0*;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-date/checkpoints/0*"
наша модель против гугловской
"ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/0*;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-date/checkpoints/11_vs_11_easy_stochastic_v2*"
мы с клавиатуры против модели
"keyboard:left_players=1;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-date/checkpoints/0*"

все нужно запускать,находясь в директории /football/
Как сделать свою архитектуру?
/football/gfootball/examples/models.py - файлик для регистрации моделей 
Пример gfootball_impala_cnn, my_gfootball_impala_cnn
в файлике /football/gfootball/examples/run_ppo2.py
в строчке
flags.DEFINE_enum('policy', 
надо добавить название своей архитектуры модели
 --verbosity flag

Если запуск на ноуте
pip3 install absl-py
MESA_GL_VERSION_OVERRIDE=3.2 MESA_GLSL_VERSION_OVERRIDE=150
--load_path
--write_videos




