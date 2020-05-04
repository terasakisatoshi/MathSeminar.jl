@def title = "C言語コードの挿入"
@def hascode = true


\chapter{C のコードの実行結果を表示}

\prop{}{ソースコードの表示}{
つぎのように C のコードを貼り付けることができる.
}

\Ccode{sample}{
#include <stdio.h>
int main(){
    printf("Hello Pika\n");
    return 0;
}
}

- ただし，環境によっては 　`include` の周りの `<` と `>` が表示されないことがある．これは `<` をマークダウンにおけるコメントと解釈してしまうためである．

```
using Markdown
Markdown.htmlesc(raw"""youccode""")
```

をしておくと回避できる場合がある. ただし，この場合だと GitHub Actions でページをビルドした場合, コードがめちゃくちゃに表示されることがわかっている．折半案は `"stdio.h"` のように二重引用符で表現することである.

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
