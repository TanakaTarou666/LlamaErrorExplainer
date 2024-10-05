function ee(){
        bash ~/explain_error.bash "$@"
}
function pythonl(){
        python 2> >(tee ~/log.txt)
}