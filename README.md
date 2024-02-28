# Fitur Lanjutan: Double Jump
Pada tutorial ini, saya memilih untuk mengimplementasikan Double Jump dan Dash sebagai fitur tambahan yang ingin saya implementasikan.

## Double Jump
Untuk mengimplementasikan fitur Double Jump, saya pertama memulai dari implementasi awal untuk membuat karakter melompat.

```gdscript
    if is_on_floor() and Input.is_action_just_pressed('up'):
        velocity.y = jump_speed
```

Pada awalnya, pengecekan lompat menggunakan metode `is_on_floor()` dari `KinematicBody2D` yang mengecek apakah player sedang *collide* dengan sebuah object `Floor`. 

Apabila pemain sedang berada di tanah, maka memencet tombol input ("up") akan membuat pemain lompat dengan memberikannya kecepatan pada axis vertikal.

Untuk mengimplementasikan Double Jump, saya menambahkan sebuah dictionary baru yang bernama `states` yang akan menyimpan state dari `Player` saat ini. 

Setiap `Player` akan memiliki state `can_double_jump` yang menentukan apakah pemain sudah menggunakan ability Double Jump-nya atau belum yang akan bernilai True by default.

Ketika `Player` sedang di udara dan menekan kembali tombol `Up`, maka kecepatan vertikal dari `Player` akan di set menjadi `jump_speed`, dan state `can_double_jump` akan di set menjadi `False`. Hal ini mencegah player bisa lompat berulang-ulang dan membatasi agar Double Jump hanya dapat digunakan sekali. State `can_double_jump` akan di set kembali menjadi `True` ketika pemain menyentuh tanah.

```gdscript
var states = {
	"can_double_jump": true
}
def get_input():
    ...
	if (is_on_floor() or states.can_double_jump) and Input.is_action_just_pressed("up"):
		if not is_on_floor():
			states.can_double_jump = false
		else:
			states.can_double_jump = true
		velocity.y = jump_speed
