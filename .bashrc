# 用于输出 git 提交日志
alias git-lg='git log --pretty=oneline --all --graph --abbrev-commit'

# 用于输出当前目录所有文件及基本信息
alias ll='ls -al'

# 检测当前运行环境
detect_terminal() {
    if [[ $TERM_PROGRAM == "vscode" ]]; then
        echo "vscode"
    elif [[ $TERM_PROGRAM == "mintty" ]]; then
        echo "gitbash"
    else 
        echo "JetBrains"
    fi
}

# 设置 PS1 提示符的函数
set_prompt() {
    case $(detect_terminal) in
        vscode|gitbash)
            # VSCode 终端使用单行提示符，不显示 $ 符号
            if git --no-optional-locks rev-parse --git-dir > /dev/null 2>&1; then
                # 在 Git 仓库中
                local git_info=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
                if [ -n "$git_info" ]; then
                    if git --no-optional-locks diff --quiet --ignore-submodules HEAD 2>/dev/null &&
                       git --no-optional-locks diff --cached --quiet 2>/dev/null &&
                       [ -z "$(git --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)" ]; then
                        # 无更改 - 显示绿色勾号
                        PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] \[\033[01;35m\]git:(\[\033[01;31m\]'$git_info'\[\033[01;35m\])\[\033[0m\] \[\033[01;32m\]✓\[\033[0m\] '
                    else
                        # 有更改 - 显示红色叉号
                        PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] \[\033[01;35m\]git:(\[\033[01;31m\]'$git_info'\[\033[01;35m\])\[\033[0m\] \[\033[01;31m\]✗\[\033[0m\] '
                    fi
                else
                    # 不在 Git 仓库中
                    PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] '
                fi
            else
                # 不在 Git 仓库中
                PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] '
            fi
            ;;
        JetBrains)
            # GoLand 终端使用两行提示符，带颜色的 Git 状态
            if git --no-optional-locks rev-parse --git-dir > /dev/null 2>&1; then
                # 在 Git 仓库中
                local git_info=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
                if [ -n "$git_info" ]; then
                    if git --no-optional-locks diff --quiet --ignore-submodules HEAD 2>/dev/null &&
                       git --no-optional-locks diff --cached --quiet 2>/dev/null &&
                       [ -z "$(git --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)" ]; then
                        # 无更改 - 显示绿色勾号
                        PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] \[\033[01;35m\]git:(\[\033[01;31m\]'$git_info'\[\033[01;35m\])\[\033[0m\] \[\033[01;32m\]✓\[\033[0m\]\n\[\033[01;33m\]$ \[\033[0m\]'
                    else
                        # 有更改 - 显示红色叉号
                        PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\] \[\033[01;35m\]git:(\[\033[01;31m\]'$git_info'\[\033[01;35m\])\[\033[0m\] \[\033[01;31m\]✗\[\033[0m\]\n\[\033[01;33m\]$ \[\033[0m\]'
                    fi
                else
                    # 不在 Git 仓库中
                    PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\]\n\[\033[01;33m\]$ \[\033[0m\]'
                fi
            else
                # 不在 Git 仓库中
                PS1='\[\033[01;35m\]\t\[\033[0m\] \[\033[01;36m\]\u\[\033[01;33m\]@\[\033[01;32m\]\h\[\033[01;33m\]:\[\033[0m\] \[\033[01;32m\]➜\[\033[0m\] \[\033[01;34m\]\W\[\033[0m\]\n\[\033[01;33m\]$ \[\033[0m\]'
            fi
            ;;
        *)
            # 默认：保持系统原生命令提示符
            ;;
    esac
}

# 每次显示提示符前调用此函数
PROMPT_COMMAND=set_prompt

# 更漂亮的 git log 别名
alias glog='git log --graph --pretty=format:"%C(yellow)%h%C(reset) %C(bold blue)%d%C(reset) %s %C(dim green)(%ar)%C(reset) %C(dim cyan)<%an>%C(reset)" --abbrev-commit --all'
