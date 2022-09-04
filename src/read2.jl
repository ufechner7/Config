using YAML, StructTypes

 mutable struct Test
    can_log::String
    sys_log::String
    version::String
    info::String
    Test() = new()
end
StructTypes.StructType(::Type{Test}) = StructTypes.Mutable()

if ! @isdefined tests; const tests = Dict{Symbol, Test}(); end

data = YAML.load_file("data/config2.yaml"; dicttype=Dict{Symbol,Any})

for pair in data
   name, test_dict = pair
   test = StructTypes.constructfrom(Test, test_dict)
   tests[name] = test
end

tests
