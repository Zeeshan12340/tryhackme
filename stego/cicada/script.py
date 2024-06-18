import cv2

detector = cv2.QRCodeDetector()

reval,point,s_qr = detector.detectAndDecode(cv2.imread("/root/TryHackMe/stego/cicada/qrcode.png"))

print(reval)
print("Points")
print(point)
print(s_qr)
