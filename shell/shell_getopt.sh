# shell_getopt.sh
getOptions "$@";





function getOptions()
{
    if [ $# = 1 ] && [[ "$@" = "-q" || "$@" = "--qt" ]] ;then
        test_mode="QT"
        argIsq=0
        return
    fi
    if [ $# = 1 ] && [[ "$@" = "-f" || "$@" = "--file" ]] ;then
        echo -e "\033[31mERROR: file .ini is needed! \033[0m"
        echoHelp
    fi
    if [ $# = 0 ] ;then
        echoHelp
        exit 0
    fi
    TEMP=`getopt -o ghf:md:c:t:o:n:v:r:qb:e: --long help,file:,debug,memorydump,deployment:,repeat:,case:,tag:,target:,note:,version,qt,branch:,env: -- "$@" 2>/dev/null`
    if [ $? != 0 ] ;then echo -e "\033[31mERROR: unknown argument! \033[0m" >&2 ; echoHelp ; fi
    eval set -- "$TEMP"

    while :
    do
        [ -z "$1" ] && break;
        case "$1" in
            -h|--help)
                echoHelp
                exit 0
            ;;
            -f|--file)
                cpConf=0
                judgeParam $1 $2
                confIni="$2"
                getOptionFromINI;
                shift 2
            ;;
            -m|--memorydump)
                memorydump=yes
                shift
            ;;
            -d|--deployment)
                judgeParam $1 $2
                deployment=$2
                shift 2
            ;;
            -c|--case)
                judgeParam $1 $2
                case=${case}" "$2
                shift 2
            ;;
            -t|--tag)
                judgeParam $1 $2
                tag=${tag}"&"$2
                shift 2
            ;;
            -o|--target)
                judgeParam $1 $2
                target=${target}" "$2
                shift 2
            ;;
            -n|--note)
                judgeParam $1 $2
                note=$2
                shift 2
            ;;
            -q|--qt)
                test_mode="QT"
                shift
            ;;
            -v|--version)
                judgeParam $1 $2
                version=$2
                shift 2
            ;;
            -r|--repeat)
                judgeParam $1 $2
                testCount=$2
                shift 2
            ;;
            -b|--branch)
                judgeParam $1 $2
                branch=`echo $2| tr a-z A-Z`
                shift 2
            ;;
            -g|--debug)
                isDirDebug='yes'
                shift
            ;;
            -e|--env)
                judgeParam $1 $2
                env=$2
                shift 2
            ;;
            --)
                shift
            ;;
            *)
                echo -e "\033[31mERROR: unknown argument! \033[0m"
                echoHelp
            ;;
        esac
    done

    suite=`echo ${suite}|awk 'gsub(/^ *| *$/,"")'`
    case=`echo ${case}|awk 'gsub(/^ *| *$/,"")'`
    tag=`echo ${tag}|awk 'gsub(/^&*|&*$/,"")'`
    target=`echo ${target}|awk 'gsub(/^ *| *$/,"")'|tr a-z A-Z`
    echoDebugInfo=`echo ${echoDebugInfo}|awk 'gsub(/^ *| *$/,"")'`
    debugInfo=`echo ${debugInfo}|awk 'gsub(/^ *| *$/,"")'`
    dumpInfo=`echo ${dumpInfo}|awk 'gsub(/^\**|\**$/,"")'`
    deployment=`echo ${deployment} | tr a-z A-Z`
}
