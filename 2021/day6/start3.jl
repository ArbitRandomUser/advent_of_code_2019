C = Base.Cartesian
fish = parse.(UInt8,split(strip(read("input",String)),","))
function part_noswap_fast_unroll(fish, simtime=80)
    C.@nexprs 9 i -> p_{i-1} = zero(UInt8)
    for f in fish
        C.@nexprs 9 i -> p_{i-1} += (f == (i-1))
    end
    C.@nexprs 9 i -> src_{i-1} = UInt(p_{i-1})
    for _ in 1:81:(simtime - mod(simtime, 81))
        C.@nexprs 9 l -> begin
            src_7 += src_0
            src_8 += src_1
            C.@nexprs 7 i -> src_{i-1} += src_{i+1}
        end
    end

    leftover = mod(simtime, 81)
    for _ in 1:9:(leftover - mod(leftover, 9))
        src_7 += src_0
        src_8 += src_1
        C.@nexprs 7 i -> src_{i-1} += src_{i+1}
    end

    leftover = mod(simtime, 9)

    src_7 += src_0 * (leftover >= 1)
    src_8 += src_1 * (leftover >= 2)
    C.@nexprs 6 i -> src_{i-1} += src_{i+1} * (leftover >= (i+2))

    C.@nexprs 8 i -> src_0 += src_{i}
    src_0
end
#part_noswap_fast_unroll(fish,256)
