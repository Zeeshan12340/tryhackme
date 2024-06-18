import PIL
from PIL import Image

from libxmp import XMPFiles, consts
from libxmp.utils import file_to_dict

source = 'for.jpeg'
dest = 'new.jpg'

new_image = PIL.Image.new(mode="RGB", size=(200, 200))
new_image.save(dest)

xmpfile = XMPFiles(file_path = source, open_forupdate = True)
xmpfile2 = XMPFiles(file_path = dest, open_forupdate = True)

xmp = xmpfile.get_xmp()
xmpfile2.put_xmp(xmp)
xmpfile2.can_put_xmp(xmp)

xmpfile.close_file()
xmpfile2.close_file()
