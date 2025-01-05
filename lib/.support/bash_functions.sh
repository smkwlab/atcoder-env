function abc() {
    open=false
    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} <contestname> [question [file]]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} 123 a Main.java"
            echo ""
            return
            ;;
        1)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1
            ;;
        *)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1/$2
            ;;
    esac

    if [ ! -d ${target} ]; then
        open=true
        am setup "${FUNCNAME[0]}${1}"
        if [ ! -d ${target} ]; then
            return 1
        fi
        echo setup "${FUNCNAME[0]}${1}"
    fi
    cd ${target}

    if [ $# -eq 3 ]; then
        if [ -f $3 ]; then
            code -r $3
        elif [ -f Main.$3 ]; then
            code -r Main.$3
        elif [ -f Main$3 ]; then
            code -r Main$3
        fi
    fi 

    if [ ${open} == true ]; then
        am open
    fi
}

function arc() {
    open=false
    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} <contestname> [question [file]]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} 123 a Main.java"
            echo ""
            return
            ;;
        1)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1
            ;;
        *)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1/$2
            ;;
    esac

    if [ ! -d ${target} ]; then
        open=true
        am setup "${FUNCNAME[0]}${1}"
        if [ ! -d ${target} ]; then
            return 1
        fi
        echo setup "${FUNCNAME[0]}${1}"
    fi
    cd ${target}

    if [ $# -eq 3 ]; then
        if [ -f $3 ]; then
            code -r $3
        elif [ -f Main.$3 ]; then
            code -r Main.$3
        elif [ -f Main$3 ]; then
            code -r Main$3
        fi
    fi 

    if [ ${open} == true ]; then
        am open
    fi
}

function ahc() {
    open=false
    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} <contestname> [question [file]]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} 123 a Main.java"
            echo ""
            return
            ;;
        1)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1
            ;;
        *)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1/$2
            ;;
    esac

    if [ ! -d ${target} ]; then
        open=true
        am setup "${FUNCNAME[0]}${1}"
        if [ ! -d ${target} ]; then
            return 1
        fi
        echo setup "${FUNCNAME[0]}${1}"
    fi
    cd ${target}

    if [ $# -eq 3 ]; then
        if [ -f $3 ]; then
            code -r $3
        elif [ -f Main.$3 ]; then
            code -r Main.$3
        elif [ -f Main$3 ]; then
            code -r Main$3
        fi
    fi 

    if [ ${open} == true ]; then
        am open
    fi
}
