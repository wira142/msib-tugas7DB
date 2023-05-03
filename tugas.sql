DELIMITER $$
CREATE PROCEDURE inputPelanggan(kode varchar(10), nama varchar(45),jk char(1),tmp_lahir varchar(30),tgl_lahir date,email varchar(45), kartu_id int(11))
BEGIN
INSERT INTO pelanggan VALUES(null,kode,nama,jk,tmp_lahir,tgl_lahir,email,kartu_id);
END$$
DELIMITER ;
CALL inputPelanggan('C001','Agung Sedayu','L','Solo','2010-01-01','sedayu@gmail.com',1);

DELIMITER $$
CREATE PROCEDURE showPelanggan(id_pelanggan int)
BEGIN 
SELECT * FROM pelanggan where id = id_pelanggan;
END $$
DELIMITER ;
CALL showPelanggan(5);

DELIMITER $$
CREATE PROCEDURE inputProduk(
  kode varchar(10),
  nama varchar(45),
  hrg_beli double,
  hrg_jual double,
  stok int(11),
  min_stok int(11),
  id_jenis int(11)
)
BEGIN
INSERT INTO produk VALUES (null, kode, nama, hrg_beli,hrg_jual,stok,min_stok,id_jenis);
END$$
DELIMITER ;
CALL inputProduk('AC01','Notebook Acer',8000000,10800000,7,2,5);

DELIMITER $$
CREATE PROCEDURE showProduk(id_produk int)
BEGIN 
SELECT * FROM produk where id = id_produk;
END $$
DELIMITER ;
CALL showProduk(5);

DELIMITER $$
CREATE PROCEDURE totalPesanan(id_pesanan int)
BEGIN
SELECT pelanggan.id, pelanggan.kode,pelanggan.nama_pelanggan,SUM(pesanan_items.qty) as total_item,pesanan.total FROM pelanggan RIGHT JOIN pesanan ON pesanan.pelanggan_id = pelanggan.id LEFT JOIN pesanan_items ON pesanan_items.pesanan_id = pesanan.id GROUP BY pesanan.id;
END $$
DELIMITER ;
CALL totalPesanan(1);

CREATE VIEW pesanan_produk_vw as SELECT pelanggan.id, pelanggan.kode, pelanggan.nama_pelanggan, pesanan.tanggal, pesanan.pelanggan_id,produk.nama,pesanan_items.qty,pesanan_items.harga FROM pelanggan RIGHT JOIN pesanan ON pelanggan.id = pesanan.pelanggan_id LEFT JOIN pesanan_items ON pesanan_items.pesanan_id = pesanan.id LEFT JOIN produk ON pesanan_items.produk_id = produk.id;