function main()
    output_dir_name="post_result"

    input_grid_dir="grid"
    nodes_name="nodes"
    elements_name="elements"
    
    input_result_dir="result"

    #vtk_頭の文字
    front="# vtk DataFile Version 2.0"+"\n"
    back="\n"+"ASCII"+"\n"+"DATASET UNSTRUCTURED_GRID"+"\n"
    write_file(output_dir_name,input_grid_dir,nodes_name,elements_name,input_result_dir,front,back)

    print("fin post.py")
end
    
def write_file(outdir,ingrid_dir,innodes,inele,inresult_dir,front,back):
    mkdir(outdir)

    ext=".dat"
    fff=glob.glob(inresult_dir+"/*"+ext)
    
    for i in range(len(fff)):
        rho,u,v,p= numpy.loadtxt(fff[i], delimiter=' ', skiprows=1, usecols=(1,2,3,4),unpack=True)
        Qbase=[rho,u,v,p]
        fname=(fff[i].split('\\')[1]).split('.')[0]
        dname=front+fname+back
        out_file=fname+".vtk"
        
        write_points(innodes,ingrid_dir,out_file,outdir,dname)
        write_cells(inele,ingrid_dir,out_file,outdir)
        write_result(Qbase,out_file,outdir)

def write_points(innodes,indir,outf,outdir,dname):
    
    fff=indir+"/"+innodes
    x, y, z= numpy.loadtxt(fff, delimiter=' ', skiprows=1, usecols=(1,2,3),unpack=True)
    
    with open(outdir+"/"+outf,'wt') as f:
        f.write(dname)
        f.write("POINTS "+str(len(x))+" float\n")
        for i in range(len(x)):
            f.write(str('{:.7f}'.format(x[i]))+" "+str('{:.7f}'.format(y[i]))+" "+str('{:.7f}'.format(z[i]))+"\n")
    
    print("fin writing points")

def write_cells(inele,indir,outf,outdir):

    fff=indir+"/"+inele
    d1,d2,d3,d4= numpy.loadtxt(fff, delimiter=' ', skiprows=1,unpack=True,dtype='int64')-1
    num_cells=len(d1)
    with open(outdir+"/"+outf,'a') as f:
        f.write("CELLS "+str(num_cells)+" "+str(int(num_cells*5))+"\n")
        for i in range(num_cells):
            f.write("4 "+str(d1[i])+" "+str(d2[i])+" "+str(d3[i])+" "+str(d4[i])+"\n")
        f.write("CELL_TYPES "+str(num_cells)+"\n")
        for i in range(num_cells):
            f.write("9\n")          #四角のみ
            
    print("fin writing cells")

def write_result(Qbase,outf,outdir):
    num_cells=len(Qbase[0])
    
    temp1="CELL_DATA "+str(num_cells)

    name=["rho","uvel","vvel","p"]
    temp2="\nSCALARS "
    temp3=" float\nLOOKUP_TABLE default\n"

    with open(outdir+"/"+outf,'a') as f:
        f.write(temp1)
        for i in range(4):
            f.write(temp2+name[i]+temp3)
            for j in range(num_cells):
                f.write(str('{:.7f}'.format(Qbase[i][j])))
                if j != num_cells-1:
                    f.write("\n")
    print("fin writing "+outf)

def mkdir(outdir):
    try:
        os.mkdir(outdir)
    except:
        pass

if __name__ == '__main__':
    main()
