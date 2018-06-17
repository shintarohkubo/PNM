#!/usr/bin/awk

BEGIN{
##### initialize
    x_pixel=10
    y_pixel=10
    for (i=1; i<=x_pixel; i++){
        for (j=1; j<=y_pixel; j++){
            frame[i,j]=0
        }
    }

    loop_num=24
##### print 0 frame
    printf ("P2\n") >> "hoge0.pgm"
    printf ("%d %d\n", x_pixel, y_pixel) >> "hoge0.pgm"
    printf ("2\n") >> "hoge0.pgm"
    for (i=1; i<=x_pixel; i++){
        for (j=1; j<=y_pixel; j++){
            printf ("%d ", frame[i,j]) >> "hoge0.pgm"
        }
        printf ("\n") >> "hoge0.pgm"
    }
    radius=2
    peripheral=1
    center_x=int(x_pixel/2.0)
    center_y=int(y_pixel/2.0)
    for (loop=1; loop<=loop_num; loop++){
##### make n frame state
        if (loop <= 3){
            center_x+=1
            center_y+=1
        } else if (3 < loop && loop <= 9){
            center_x-=1
        } else if (9 < loop && loop <= 15){
            center_y-=1
        } else if (15 < loop && loop <= 21){
            center_x+=1
        } else if (21 < loop && loop <= 24){
            center_x-=1
            center_y+=1
        }
        for (i=1; i<=x_pixel; i++){
            for (j=1; j<=y_pixel; j++){
                dist=(i-center_x)^2+(j-center_y)^2
                if (dist <= radius^2){
                    frame[i,j]=2
                } else if (radius^2 < dist && dist <= (radius+peripheral)^2){
                    frame[i,j]=1
                } else {
                    frame[i,j]=0
                }
            }
        }
##### print n frame
        printf ("P2\n") >> "hoge"loop".pgm"
        printf ("%d %d\n", x_pixel, y_pixel) >> "hoge"loop".pgm"
        printf ("2\n") >> "hoge"loop".pgm"
        for (i=1; i<=x_pixel; i++){
            for (j=1; j<=y_pixel; j++){
                printf ("%d ", frame[i,j]) >> "hoge"loop".pgm"
            }
            printf ("\n") >> "hoge"loop".pgm"
        }
    }
}
