# Baseline

1) Обучим модель с новой архитектурой cnn_small.

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

Добавим также нашу модель в файлик /football/gfootball/examples/run_ppo2.py .

```
flags.DEFINE_enum('policy', 'cnn', ['cnn', 'lstm', 'mlp', 'impala_cnn',
                                    'gfootball_impala_cnn', *'cnn_small'*]
                  'Policy architecture')
'''
