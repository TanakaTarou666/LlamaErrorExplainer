if [ "$#" -eq 0 ]; then
    ollama run elyza:7b-instruct <<EOF
以下のエラーが出ています。解説と改善案を出して。
$(cat ~/log.txt)
EOF
    <<EOF
/bye
EOF
    exit 1
fi

# コードファイルの内容を連結
code_content=""
for code_file in "$@"; do
    if [ -f "$code_file" ]; then
        # ファイル名と内容を連結
        code_content+="ファイル名:${code_file}\n"
        code_content+="コード:\n$(cat "$code_file")\n"
    else
        echo "警告: '$code_file' は存在しないファイルです。"
    fi
done

# エラー文を解説して改善案を出力
ollama run elyza:7b-instruct <<EOF
以下のエラーが出ています。解説と改善案を出して。
$(cat ~/log.txt)
${code_content}
EOF
    <<EOF
/bye
EOF
