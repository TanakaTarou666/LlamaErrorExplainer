# エラー文を解説して改善案を出力
ollama run elyza:7b-instruct <<EOF
以下のエラーが出ています。改善案を出して。
$(cat ~/log.txt)
EOF
    <<EOF
/bye
EOF
