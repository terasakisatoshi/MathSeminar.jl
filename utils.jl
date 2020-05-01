using Franklin

mutable struct Theorem
    chapter::Int
    section::Int
    subsection::Int
    Theorem()=new(0,0,0)
end

mutable struct State 
    level::Symbol
    thm::Theorem
    label2thm::Dict{Any,Any}
end

init() = State(:chapter, Theorem(), Dict())

# global state
state = init()

function setlevel(new::Symbol)
    global state
    state.level = new
end

setlevel(new::AbstractString) = setlevel(Symbol(new))

function lx_setlevel(com, _)
    brace_content = Franklin.content(com.braces[1])
    setlevel(brace_content)
    return ""
end

function record_theorem_number(label)
    global state
    state.label2thm[label] = deepcopy(state.thm)
end

function generate_label(label)
    if label != ""
        return "\\label$(label)"
    else
        return ""
    end
end

function generate_name(name)
    if name != ""
        return "($(name))"
    else
        return ""
    end
end

function increment()
    global state
    t = state.thm
    if state.level == :chapter && (t.chapter += 1) end
    if state.level == :section && (t.section += 1) end
    if state.level == :subsection && (t.subsection += 1) end
    # update
    state.thm = t
end

function lx_increment(com, _)
    increment()
    return ""
end

function resetcount()
    global state
    t = state.thm
    if state.level == :chapter && (t.chapter = 0) end
    if state.level == :section && (t.section = 0) end
    if state.level == :subsection && (t.subsection = 0) end
    # update
    state.thm = t
end

function lx_resetcount(com, _)
    resetcount()
    return ""
end


getnum(t::Theorem)="$(t.chapter).$(t.section).$(t.subsection)"

function getnum()
    global state 
    getnum(state.thm)
end

function ref(label::AbstractString)
    global state
    try
        n = getnum(state.label2thm[label])    
        return "[$n](#$label)"
    catch
        @warn "fail to ref $label"
        return "???"
    end

end

function lx_ref(com, _)
    brace_content = Franklin.content(com.braces[1])
    ref(brace_content)
end

function lx_juliatheorem(com, _)
    global state
    increment()
    brace_content = Franklin.content(com.braces[1])
    record_theorem_number(brace_content)
    t = state.thm
    "counter_$(t.chapter)_$(t.section)_$(t.subsection)"
end


