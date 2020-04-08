@def title = "ようこそ"
@def hasmath = true
@def hascode = true


\toc <!-- table of contents -->


\chapter{C のコードの実行結果を表示}

\prop{(ソースコードの表示)}{
つぎのように C のコードを貼り付けることができる.
}

\Ccode{sample}{
#include <stdio.h>
int main(){
    printf("Hello Pika\n");
    return 0;
}
}

\input{c}{sample.md}
\input{plaintext}{sample.md}

`include` の周りの `<` と `>` は取り扱いに注意が必要.

\Cexec{how2embeddC}{
#include "stdio.h"
int main(){
    printf("Hello World\n");
    return 0;
}
}

<!-- theorem 環境でバッククォーとが必要になる場合は newcommand を使わず @@theorem ... @@ を使うようにする -->
@@remark (Cのコードのハイライト)
    [Getting hightlight.js](https://highlightjs.org/download/)　から ハイライトしたい言語を選択した後 `highlight.pack.js` を `_lib/hightlight` にコピーする. もともと `_lib/highlight/highlight.pack.js` が配置されているが、Julia,Python,R、Markdownのみをハイライトするようになっている。
@@
