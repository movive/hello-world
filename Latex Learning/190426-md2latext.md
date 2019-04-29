若想将Markdown文件转换成Latex文件，可以使用Pandoc进行。
若要生成一个独立的Latex文件，可以输入`pandoc file1.md -f markdown -s -t latex -o file2.tex`，也可以简化为`pandoc file1.md -s -o file2.tex`。Pandoc会自动识别目标文件与输出文件的文件类型。
若要生成一个Latex代码片段，可以输入`pandoc file1.md -o file2.tex`，这样系统不会生成`\documentclass`或`\begin{document}`之类构成Latex文档的必要元素。
