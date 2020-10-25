direccion="/home/miguel/Documentos/arc_angela" #ingrese la ruta para escanear los archivos
md5_guardados=(08b5e6f413402603ae48100110bac99b 7264a79cccb5da23e0d37c504309af3d 40744679dff4bf36705c00f9cb815579 0beac18480a527f29818d8c8b2964c74)
declare -a arreglo
contador=0
for arch in $(ls $direccion)
do
    md5sum $direccion/$arch > tem.txt
    for posibilidades in ${md5_guardados[@]}
    do
        grep -w $posibilidades tem.txt 
        if [ $? -eq 0 ];
        then
            arreglo[$contador]=$arch
            contador=$(($contador +1))
        fi
    done
    rm tem.txt
done
contador_arch=0
x=0
for arch in $(ls $direccion)
do
    x=0
    for arch_c in ${arreglo[@]}
    do
        if [ "$arch" = "$arch_c" ];
        then
            x=1
            break
        fi
    done

    if [ $x -eq 1 ];
    then
        cat $direccion/$arch | base64 > "$contador_arch.txt"
    else
        cat $direccion/$arch | base64 --decode > "$contador_arch.png"
    fi
    contador_arch=$(($contador_arch +1))
done