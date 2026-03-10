# GODOT GAMESPACE SEMESTER GENAP

## 1. Movement & Feel 

### Velocity & move_and_slide()
Movement di godot itu sendiri dan kebanyakan engine itu dipengaruhi oleh Velocity. Velocity lebih banyak digunakan karena bisa mengatur atau menyesuaikan dengan pemrosesan fisika. 
Berbeda dengan engine lain, untuk menjalankan velocity dan pemrosesan fisika lain itu menggunakan fungsi bernama `move_and_slide()`. 

### Smooth
Pergerakan pada game memang bisa dilakukan dengan hanya velocity dan proses fisika lain. Namun, pada kasus tertentu terasa hambar karena tidak ada berat atau weight dari karakter. Untuk menambahkan smooth itu ada dua cara yang bisa dilakukan 
1. `move_toward(current, target, delta)` -> mengubah nilai secara linier. Artinya, setiap frame nilainya berubah dengan jumlah yang pasti dan sama sampai mencapai target
2. `lerp(from, to, weight)` -> mengubah nilai berdasarkan persentase/bobot. Artinya, semakin dekat nilai dengan target, pergerakannya akan semakin lambat.

### Coyote Time & Jump Buffer 
Coyote Time dan Jump Buffer itu sangat erat kaitannya dengan Jump, entah itu di 2D atau 3D dua hal ini itu ada. 
1. Coyote Time sendiri itu seperti kamu diberikan waktu mengambang diudara dan diizinkan melompat. Coyote Time itu ada karena banyak player yang sering menggunakan momentum melompat di ujung ground atau ledge. Jika tidak menggunakan Coyote Time, karakter akan langsung jatuh dan player tidak ada kesempatan untuk lompat.
2. Jump Buffer itu ibaratkan kamu menyimpan lompatan untuk digunakan nanti setelah karakter menyentuh tanah. Kamu bisa menekan tombol jump diudara, dan akan disimpan sementara. Saat sudah mendarat di ground simpanan tadi akan langsung dikeluarkan, dan membuat karaktermu melompat

## 2. Interaction System & Inventory Logic

### Perbedaan Deteksi Antaran Area dan Raycast
Dalam godot engine sendiri untuk melakukan deteksi item atau apapun itu yang bisa diinteraksi di dalam game dapat menggunakan dua cara. Pertama, bisa menggunakan raycast (laser detectection) dan area (area detection). Kedua cara itu sering di gunakan di dalam pengembangan game. Namun perbedaannya apa sih ?. Oke berikut perbedaannya. 

1. Racyast : raycast itu diibaratkan sebagai laser yang ditembakkan lurus pada jarak tertentu. Raycast ini sangat presisi, cocok untuk pendeteksian yang lebih spesifik. Raycast bekerja dengan menembakkan laser lurus kedepan, dan ketika ada object yang dikeaninya, makan raycast akan memberitahu bahwa dia sudah mengenai object.
2. Area : Area itu diibaratkan aura yang ada mengelilingi object. Apapun yang masuk ke arae itu akan dideteksi oleh object tersebut. Berbeda dengan raycast yang sangat presisi, area berbeda. Dia mengecek semua object yang masuk tanpa terkecuali, dan tidak bisa memilih object apa yang ingin dilihat, tidak seperti raycast. Untuk memilih object yang akan diinteraksi, arae harus memiliki logika pengecekan jarak paling dekat.

