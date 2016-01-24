
with open('test1.txt', 'wt', encoding='utf-8') as f:
    print('Hello,Python!','你好python')

with open('test1.txt', 'xt', encoding='utf-8') as f:
   f.write('x模式:因为文件已经存在所以会报错', file=f)