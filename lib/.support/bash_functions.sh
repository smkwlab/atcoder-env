function abc() {
    case $# in
        0)
            echo "Change contest/question directory"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} <contestname> [question]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            return
            ;;
        1)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1
            ;;
        2)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1/$2
            ;;
    esac

    if [ -d ${target} ]; then
        cd ${target}
    else
        echo ${target} not exists
    fi
}


function ahc() {
    case $# in
        0)
            echo "Change contest/question directory"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} <contestname> [question]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            return
            ;;
        1)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1
            ;;
        2)
            target=${CONTEST_DIR}/${FUNCNAME[0]}$1/$2
            ;;
    esac

    if [ -d ${target} ]; then
        cd ${target}
    else
        echo ${target} not exists
    fi
}
