#!/usr/bin/julia

using Gadfly;
using DataFrames;

data = readtable(ARGS[1], separator='\t', header=false);
# format of the data:
# x1        x2      x3      x4
# DATETIME  NAME    ACTIVE  FRACTION
data[:time] = map(x -> parse(Int, split(x, '_')[4]), data[:x1])

layer_active = layer(
    x=data[:time],
    y=data[:x3],
    Geom.smooth
    )


layer_fraction = layer(
    x=data[:time],
    y=data[:x4],
    Geom.smooth,
    Theme(default_color=colorant"orange")
    ) 


out = SVG("svg/$(data[:x2][1]).svg", 6inch, 4inch)

p = Gadfly.plot(
    layer_active,
    layer_fraction,
    Guide.xlabel("Time (Hours)"),
    Guide.ylabel("Bikes"),
    Guide.title(data[:x2][1]),
    Guide.manual_color_key("legend", ["active", "fraction of actives"], ["deepskyblue", "orange"])
)


draw(out, p)