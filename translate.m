function A = translate(f)
%翻译某一频率对应的钢琴键
%A

level = round(log2(f/220)*12);
A = mod(level,12);