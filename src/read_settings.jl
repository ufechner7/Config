using YAML, Parameters, StructTypes

include("wc_settings.jl")
StructTypes.StructType(::Type{WCSettings}) = StructTypes.Mutable()

const SETTINGS = WCSettings() 

function update_settings(dict, sections)
    result = Dict{Symbol, Any}()
    for section in sections
        sec_dict = Dict(Symbol(k) => v for (k, v) in dict[section])
        merge!(result, sec_dict)
    end
    StructTypes.constructfrom!(SETTINGS, result)
end

dict = YAML.load_file("data/wc_settings.yaml")
update_settings(dict, ["wc_settings"])