function abc() {
    local open=false
    local lang=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -l)
                if [ -n "$2" ]; then
                    lang=$2
                    shift 2
                else
                    echo "Error: -l requires a language argument" >&2
                    return 1
                fi
                ;;
            *)
                break
                ;;
        esac
    done

    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} [-l language] <contestname> [question]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} -l java 123 a"
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

    if [ ! -z "$lang" ]; then
        if [ -f Main.$lang ]; then
            code -r Main.$lang
        elif [ -f Main$lang ]; then
            code -r Main$lang
        fi
    fi

    if [ ${open} == true ]; then
        am open
    fi
}

function arc() {
    local open=false
    local lang=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -l)
                if [ -n "$2" ]; then
                    lang=$2
                    shift 2
                else
                    echo "Error: -l requires a language argument" >&2
                    return 1
                fi
                ;;
            *)
                break
                ;;
        esac
    done

    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} [-l language] <contestname> [question]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} -l java 123 a"
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

    if [ ! -z "$lang" ]; then
        if [ -f Main.$lang ]; then
            code -r Main.$lang
        elif [ -f Main$lang ]; then
            code -r Main$lang
        fi
    fi

    if [ ${open} == true ]; then
        am open
    fi
}

function ahc() {
    local open=false
    local lang=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            -l)
                if [ -n "$2" ]; then
                    lang=$2
                    shift 2
                else
                    echo "Error: -l requires a language argument" >&2
                    return 1
                fi
                ;;
            *)
                break
                ;;
        esac
    done

    case $# in
        0)
            echo "Change contest/question directory and open file"
            echo ""
            echo "Usage:"
            echo "       ${FUNCNAME[0]} [-l language] <contestname> [question]"
            echo ""
            echo "Example:"
            echo "       ${FUNCNAME[0]} 123 a"
            echo ""
            echo "       ${FUNCNAME[0]} -l java 123 a"
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

    if [ ! -z "$lang" ]; then
        if [ -f Main.$lang ]; then
            code -r Main.$lang
        elif [ -f Main$lang ]; then
            code -r Main$lang
        fi
    fi

    if [ ${open} == true ]; then
        am open
    fi
}
