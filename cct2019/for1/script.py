def add_xmp(source: str, dest: str):
    
    with open(source, 'r+b') as file_1:
        o_img = file_1.read()

    xmp_start = o_img.find(b'http://ns.adobe.com/xap/1.0/\0')
    xmp_end = o_img.find(b'\xff\xdb', xmp_start)

    if xmp_start == -1:
        return

    xmp_str = o_img[xmp_start - 4: xmp_end]

    with open(dest, 'r+b') as file_2:
        d_img = file_2.read()

        xmp_end = d_img.find(b'\xff\xdb')

        first_part = d_img[:xmp_end]
        second_part = d_img[xmp_end:]

        new_str = first_part + xmp_str + second_part

        file_2.seek(0)
        file_2.truncate()
        file_2.write(new_str)
        file_2.close()
