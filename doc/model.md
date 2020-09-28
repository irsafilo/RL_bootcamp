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
 
