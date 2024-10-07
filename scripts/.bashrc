function ee(){
        bash ~/explain_error.bash 
}

function pythonl(){
        python3 "$@" 2> >(tee ~/log.txt)
}