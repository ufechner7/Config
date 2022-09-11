using YAML, Parameters, StructTypes, StructEquality

include("fpc_settings.jl")
StructTypes.StructType(::Type{FPCSettings}) = StructTypes.Mutable()
@struct_hash_equal FPCSettings

const SETTINGS = FPCSettings() 

function update_settings(dict, sections)
    result = Dict{Symbol, Any}()
    for section in sections
        sec_dict = Dict(Symbol(k) => v for (k, v) in dict[section])
        merge!(result, sec_dict)
    end
    StructTypes.constructfrom!(SETTINGS, result)
end

dict = YAML.load_file("data/fpc_settings.yaml")
OLD = deepcopy(SETTINGS)
@assert OLD == SETTINGS
update_settings(dict, ["fpc_settings"])

@assert struct_isapprox(OLD, SETTINGS, rtol=1e-12)