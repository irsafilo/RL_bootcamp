# Инструкция запуска на ноуте (linux + видеокарта)

1) Скачать ```start_laptop.sh```

Выполним команду ```cat start_laptop.sh``` , чтобы посмотреть содержимое файла.

``` 
sudo apt-get update
sudo apt-get -y install git cmake build-essential libgl1-mesa-dev libsdl2-dev \
libsdl2-image-dev libsdl2-ttf-dev libsdl2-gfx-dev libboost-all-dev \
libdirectfb-dev libst-dev mesa-utils xvfb x11vnc libsdl-sge-dev python3-pip
git clone https://github.com/google-research/football.git
cd football
sudo apt-get -y install python3-venv
python3 -m venv football-env
source football-env/bin/activate
pip3 install scikit-build
pip3 install .
python3 -m pip install --upgrade pip setuptools
pip3 install tensorflow-gpu==1.15.*
pip3 install dm-sonnet==1.*
pip3 install git+https://github.com/openai/baselines.git@master
pip3 install absl-py
```
2) Выполнить команду
  ```sudo bash start_laptop.sh```
Будет происходить загрузка необходимых библиотек. Время выполнения 1-2 часа.
Затем нужно будет перейти в директорию football, которая будет создана после запуска предыдущего скрипта,
и активировать окружение следующими командами.
  ```
  cd football
  source football-env/bin/activate
  ```
  
 3) Проверка рендеринга игры
 
 ```
 sudo MESA_GL_VERSION_OVERRIDE=3.2 MESA_GLSL_VERSION_OVERRIDE=150
 python3 -m gfootball.play_game --action_set=full
 ```
 В случае проблем с tensorflow может помочь обновление tensorflow-gpu до более новых версий.

# Инструкция запуска на виртуальной машине

1) Скачать start.sh
2) Выполнить 
  ```bash start.sh```
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

4) Попробовать запустить игру можно так.
  Наша модель будет играть против нашей же модели.
```
python3 -m gfootball.play_game --players 
"ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/0*;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг}"
```
