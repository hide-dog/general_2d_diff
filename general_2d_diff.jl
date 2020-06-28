# src path
#src_path="C:\\Users\\秀人\\Downloads\\一般二次元座標拡散方程式-20200430T100734Z-001\\一般二次元座標拡散方程式\\一般座標系\\General2d_diff\\src\\"
src_path="C:\\Users\\Koike\\Desktop\\git\\general_2d_diff\\src\\"

# main (変更しないこと)
src_read="read_grid.jl"
include(src_path*src_read)
src_read="read_para.jl"
include(src_path*src_read)
src_read="output.jl"
include(src_path*src_read)
src_read="boundary.jl"
include(src_path*src_read)
src_read="misc.jl"
include(src_path*src_read)
src_read="value_setup.jl"
include(src_path*src_read)
src_read="rhs.jl"
include(src_path*src_read)
src_read="cal_time_step.jl"
include(src_path*src_read)
src_main="main.jl"
include(src_path*src_main)


