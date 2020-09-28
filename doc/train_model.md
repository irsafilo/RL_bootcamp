# Режимы обучения модели

В рамках стратегии PPO2 (https://openai.com/blog/openai-baselines-ppo/#ppo)
можно обучать модель с разными архитектурами - *cnn, impala_cnn, mlp, lstm, gfotball_impala_cnn*.
Их можно передать в параметре ```--policy```.
```
python3 -u -m gfootball.examples.run_ppo2 \
  --level 11_vs_11_easy_stochastic \
  --reward_experiment scoring \
  --policy impala_cnn
```


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
