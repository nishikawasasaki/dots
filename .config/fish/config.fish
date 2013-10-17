# alias や function で作った別名コマンドに補完を適用する関数
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

# ログインメッセージ無効
set fish_greeting ""


# cd したあとに ls
function cd
    builtin cd $argv; ls
end

# emacsclient を ec で
function ec
    emacsclient -n $argv
end

# git を g で
function g
    git $argv
end
# g で実行する git に補完実行
make_completion g 'git'