# NVIM
leader = space 

    \<leader\> h = clear search 
    \<leader\> rn = rename 
    gD, gd, gi = go to delaration, definition, implementation
    K = hover snippet 
    \<leader\> k = RUST ?
    \<leader\> a = RUST ?
    c-i, c-o = forward, back 
    \<leader\> \<leader\> = show recently open files 
    \<leader\> fg = live grep 
    \<leader\> fh = help tags telescope? 

For folding use Neovim's regular folding commands:

    Toggle a fold: za
    Open a fold: zo
    Close a fold: zc
    Open all folds: zR
    Close all folds: zM

# T-Mux 

leader = Ctrl \+ s

Management

    \<leader\> % = split pane vertically
    \<leader\> " = split pane horizantally
    \<leader\> c = new window 
    \<leader\> space = switch between builtin layouts 
    \<leader\> : = commands
        rename-window
        rename-session

Management Sessions 

    \<leader\> d = detach from session
    \<leader\> s = list all session

Movement

    \<leader\> h,j,k,l = move around like in vim 
    Ctrl \+ h,j,k,l = move around like in vim due to plugin   
    \<leader\> s = change session
    \<leader\> n = change window
    \<leader\> {,} = move panes around  

tmux ls - list sessions 
tmux attach - attach to session
