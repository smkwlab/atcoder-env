function abc() {
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

    if [ -d ${target} ]; then
        cd ${target}
    else
        echo ${target} not exists
    fi

    if [ $# -eq 3 ] && [ -f $3 ]; then
       code -r $3
    fi
}

function arc() {
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

    if [ -d ${target} ]; then
        cd ${target}
    else
        echo ${target} not exists
    fi

    if [ $# -eq 3 ] && [ -f $3 ]; then
       code -r $3
    fi
}

function ahc() {
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

    if [ -d ${target} ]; then
        cd ${target}
    else
        echo ${target} not exists
    fi

    if [ $# -eq 3 ] && [ -f $3 ]; then
       code -r $3
    fi
}
