# Игра

Попробовать запустить игру можно так.
  - Наша модель будет играть против нашей же модели.
```
python3 -m gfootball.play_game --players 
"ppo2_cnn:left_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/0*;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг}"
```
- Наша модель будет играть против гугловской модели.
```
python3 -m gfootball.play_game --players "ppo2_cnn:left_players=1,policy=impala_cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг};ppo2_cnn:right_players=1,policy=gfootball_impala_cnn,checkpoint=/tmp/openai-date/checkpoints/11_vs_11_easy_stochastic_v2"
```
Гугловская модель лежит в папке ```/RL_bootcamp/models/```. 
Для запуска игры моделей в режиме policy PPO2 надо явно указывать policy и checkpoint.
Для гугловской модели это - ```policy=gfootball_impala_cnn```

- Будем играть против обученной модели с клавиатуры.
```
python3 -m gfootball.play_game --players 
"keyboard:left_players=1;ppo2_cnn:right_players=1,policy=cnn,checkpoint=/tmp/openai-{дата-время}/checkpoints/{шаг}"
```
Все команды нужно запускать, находясь в директории ```/football/``` на виртуальной машине.

 
