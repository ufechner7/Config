using YAML, StructTypes

 mutable struct Test
    can_log::String
    sys_log::String
    version::String
    info::String
    Test() = new()
end
StructTypes.StructType(::Type{Test}) = StructTypes.Mutable()

const tests = Test[]

data = YAML.load_file("data/config.yaml"; dicttype=Dict{Symbol,Any})

for test_dict in data[:tests]
    test = StructTypes.constructfrom(Test, test_dict)
    push!(tests, test)
end

tests
