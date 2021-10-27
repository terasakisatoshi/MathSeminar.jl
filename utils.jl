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

# global state
state = State(:chapter, Theorem(), Dict())

function lx_initcounter(com, _)
    global state
    state = State(:chapter, Theorem(), Dict())
    return ""
end

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

function lx_generateLabel(com, _)
    label = Franklin.content(com.braces[1])
    if label != ""
        return "\\label{$(label)}"
    else
        return ""
    end
end

function lx_generateTheoremName(com, _)
    name = Franklin.content(com.braces[1])
    if name != ""
        return "($name)"
    else
        return ""
    end
end

function increment()
    global state
    t = state.thm
    state.level == :chapter && (t.chapter += 1)
    state.level == :section && (t.section += 1)
    state.level == :subsection && (t.subsection += 1)
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
    state.level == :chapter && (t.chapter = 0)
    state.level == :section && (t.section = 0)
    state.level == :subsection && (t.subsection = 0)
    # update
    state.thm = t
end

function lx_resetcount(com, _)
    resetcount()
    return ""
end


get_theorem_number(t::Theorem)="$(t.chapter).$(t.section).$(t.subsection)"

function get_theorem_number()
    global state
    get_theorem_number(state.thm)
end

function lx_getTheoremNumber(com, _)
    global state
    get_theorem_number(state.thm)
end

function ref(label::AbstractString)
    global state
    try
        n = get_theorem_number(state.label2thm[label])
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

function lx_recordTheoremNumber(com, _)
    brace_content = Franklin.content(com.braces[1])
    record_theorem_number(brace_content)
    return ""
end

function lx_bold(com, _)
    text = Franklin.content(com.braces[1])
    return "__$(text)__"
end
