use fakeshoppi;


-- Ex02
-- Thêm khóa ngoại cho bảng products
ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (categoryId) REFERENCES categories(categoryId);

ALTER TABLE products
ADD CONSTRAINT fk_products_stores
FOREIGN KEY (storeId) REFERENCES stores(storeId);

-- Thêm khóa ngoại cho bảng images
ALTER TABLE images
ADD CONSTRAINT fk_images_products
FOREIGN KEY (productId) REFERENCES products(productId);

-- Thêm khóa ngoại cho bảng reviews
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_users
FOREIGN KEY (userId) REFERENCES users(userId);

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_products
FOREIGN KEY (productId) REFERENCES products(productId);

-- Thêm khóa ngoại cho bảng carts
ALTER TABLE carts
ADD CONSTRAINT fk_carts_users
FOREIGN KEY (userId) REFERENCES users(userId);

ALTER TABLE carts
ADD CONSTRAINT fk_carts_products
FOREIGN KEY (productId) REFERENCES products(productId);

-- Thêm khóa ngoại cho bảng orders
ALTER TABLE orders
ADD CONSTRAINT fk_orders_users
FOREIGN KEY (userId) REFERENCES users(userId);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_stores
FOREIGN KEY (storeId) REFERENCES stores(storeId);

-- Thêm khóa ngoại cho bảng order_details
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_orders
FOREIGN KEY (orderId) REFERENCES orders(orderId);

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (productId) REFERENCES products(productId);

-- Thêm khóa ngoại cho bảng stores
ALTER TABLE stores
ADD CONSTRAINT fk_stores_users
FOREIGN KEY (userId) REFERENCES users(userId);


-- Ex03
-- Liệt kê tất cả các thông tin về sản phẩm (products).
select * from products;


-- Tìm tất cả các đơn hàng (orders) có tổng giá trị (totalPrice) lớn hơn 500,000.
select * from orders where totalPrice > 50000;


-- Liệt kê tên và địa chỉ của tất cả các cửa hàng (stores).
select storeName, addressStore from stores;


-- Tìm tất cả người dùng (users) có địa chỉ email kết thúc bằng '@gmail.com'.
select * from users where email like "%@gmail.com";


-- Hiển thị tất cả các đánh giá (reviews) với mức đánh giá (rate) bằng 5.
select * from reviews where rate = 5;


-- Liệt kê tất cả các sản phẩm có số lượng (quantity) dưới 10.
select * from products where quantity < 10;


-- Tìm tất cả các sản phẩm thuộc danh mục categoryId = 1.
select * from products where categoryId = 1;


-- Đếm số lượng người dùng (users) có trong hệ thống.
select count(userId) from users;


-- Tính tổng giá trị của tất cả các đơn hàng (orders).
select sum(totalPrice) from orders;


-- Tìm sản phẩm có giá cao nhất (price).
select productName, price from products
order by price desc limit 1;


-- Liệt kê tất cả các cửa hàng đang hoạt động (statusStore = 1).
select storeName, statusStore from stores where statusStore = 1;


-- Đếm số lượng sản phẩm theo từng danh mục (categories).
select c.categoryId, c.categoryName, count(p.productId) as totoalProducts
from categories c
join products p on p.categoryId = c.categoryId
group by c.categoryId;


-- Tìm tất cả các sản phẩm mà chưa từng có đánh giá.
select productName
from products 
where productId not in (select distinct productId from reviews);


-- Hiển thị tổng số lượng hàng đã bán (quantityOrder) của từng sản phẩm.
select p.productName, od.quantityOrder
from products p
join order_details od on p.productId = od.productId
group by p.productName;


-- Tìm các người dùng (users) chưa đặt bất kỳ đơn hàng nào.
select * from users where userId not in (select distinct userId from orders);


-- Hiển thị tên cửa hàng và tổng số đơn hàng được thực hiện tại từng cửa hàng.
select s.storeName, count(o.orderId) as totalProducts from stores s
join orders o on o.storeId = s.storeId
group by s.storeName;


-- Hiển thị thông tin của sản phẩm, kèm số lượng hình ảnh liên quan.
select p.productName, p.price, p.description, count(i.imageId) as totalImage
from products p
join images i on i.productId = p.productId
group by p.productName;


-- Hiển thị các sản phẩm kèm số lượng đánh giá và đánh giá trung bình.
select p.productName, p.price, p.description, count(r.reviewId) as totalReviews, avg(r.rate) as avgReviews
from products p
join reviews r on p.productId = r.productId
group by p.productName;


-- Tìm người dùng có số lượng đánh giá nhiều nhất.
select u.userName, count(r.reviewId) as totalReviews
from users u
join reviews r on r.userId = u.userId
group by u.userName
order by totalReviews desc;


-- Hiển thị top 3 sản phẩm bán chạy nhất (dựa trên số lượng đã bán).
select productName, quantitySold from products p 
order by quantitySold desc limit 3;


-- Tìm sản phẩm bán chạy nhất tại cửa hàng có storeId = 'S001'.
select s.storeId, p.productName, p.quantitySold
from stores s 
join products p on s.storeId = p.storeId
where s.storeId like "%S001%";


-- Hiển thị danh sách tất cả các sản phẩm có giá trị tồn kho lớn hơn 1 triệu (giá * số lượng).
select productId, (price * quantity) as tonkhovalue
from products
where (price * quantity)  > 1000000;


-- Tìm cửa hàng có tổng doanh thu cao nhất.
select s.storeName, sum(o.totalprice) as doanhthu
from stores s
join orders o on s.storeId = o.storeId
group by s.storeName
order by doanhthu desc limit 1;


-- Hiển thị danh sách người dùng và tổng số tiền họ đã chi tiêu.
select u.userName, sum(o.totalprice) as tongchitieu
from users u
join orders o on u.userId = o.userId
group by u.userName;


-- Tìm đơn hàng có tổng giá trị cao nhất và liệt kê thông tin chi tiết.
select * from orders o
join order_details od on od.orderId = o.orderId
order by o.totalPrice desc limit 1;


-- Tính số lượng sản phẩm trung bình được bán ra trong mỗi đơn hàng.
select o.orderId, avg(od.quantityOrder) as avgQuantity
from orders o
join order_details od on od.orderId = o.orderId
group by o.orderId;


-- Hiển thị tên sản phẩm và số lần sản phẩm đó được thêm vào giỏ hàng.
select p.productName, sum(c.quantityCart) as totalInCart
from products p
join carts c on p.productId = c.productId
group by p.productName;


-- Tìm tất cả các sản phẩm đã bán nhưng không còn tồn kho trong kho hàng.
select productName
from products
where quantity = 0 and quantitySold > 0;


-- Tìm các đơn hàng được thực hiện bởi người dùng có email là duong@gmail.com'.
select u.email, o.orderId
from users u
join orders o on u.userId = o.userId
where u.email like "duong@gmail.com";


-- Hiển thị danh sách các cửa hàng kèm theo tổng số lượng sản phẩm mà họ sở hữu.
select s.storeName, count(p.productId) as totalProduct
from stores s
join products p on s.storeId = p.storeId
group by s.storeName;



-- Ex04
-- View hiển thị tên sản phẩm (productName) và giá (price) từ bảng products 
-- với giá trị giá (price) lớn hơn 500,000 có tên là expensive_products
create view expensive_products as
	select productName, price from products where price > 500000;


-- Truy vấn dữ liệu từ view vừa tạo expensive_products
select * from expensive_products;

-- Làm thế nào để cập nhật giá trị của view? Ví dụ, cập nhật giá (price) thành 600,000 cho sản phẩm có tên Product A 
-- trong view expensive_products.
update expensive_products 
set price = 600000
where productName = "Product A";


-- Làm thế nào để xóa view expensive_products?
DROP VIEW expensive_products;


--  Tạo một view hiển thị tên sản phẩm (productName), tên danh mục (categoryName) bằng cách kết hợp bảng products và categories.
create view qwer as
	select p.productName, c.categoryName from products p
    join categories c on c.categoryId = p.categoryId;


-- Ex05
-- Làm thế nào để tạo một index trên cột productName của bảng products?
create index idx_proName on products(productName);


-- Hiển thị danh sách các index trong cơ sở dữ liệu?
show index from products;


-- Trình bày cách xóa index idx_productName đã tạo trước đó?
ALTER TABLE products
DROP INDEX idx_proName;


-- Tạo một procedure tên getProductByPrice để lấy danh sách sản phẩm với giá lớn hơn một giá trị đầu vào (priceInput)?
delimiter $$
create procedure getProducByPrice(in priceInput int)
begin
	select * from products where price > priceInput;
end$$
delimiter ;


-- Làm thế nào để gọi procedure getProductByPrice với đầu vào là 500000?
call getProductByPrice(500000);


-- Tạo một procedure getOrderDetails trả về thông tin chi tiết đơn hàng với đầu vào là orderId?
delimiter $$
create procedure getOrderDetails(in orderid varchar(255))
begin
	select * from orders where orderId like orderid;
end$$
delimiter ;


-- Làm thế nào để xóa procedure getOrderDetails?
drop procedure getOrderDetails;


-- Tạo một procedure tên addNewProduct để thêm mới một sản phẩm vào bảng products.
-- Các tham số gồm productName, price, description, và quantity.
delimiter $$
create procedure addNewProduct(in ProductName varchar(255), in Price int, in Quantity int)
begin
	insert into products (productName, price, quantity) values (ProductName, Price, Quantity);
end$$
delimiter ;


-- Tạo một procedure tên deleteProductById để xóa sản phẩm khỏi bảng products dựa trên tham số productId.
delimiter $$
create procedure deleteProductById(in ProductId varchar(255))
begin
	delete from products where productId like ProductId;
end$$
delimiter ;



-- Tạo một procedure tên searchProductByName để tìm kiếm sản phẩm theo tên (tìm kiếm gần đúng) từ bảng products.
delimiter $$
create procedure searchProductByName(in sname varchar(255))
begin
	select * from products where productName like sname;
end$$
delimiter ;

-- Tạo một procedure tên filterProductsByPriceRange để lấy danh sách sản phẩm có giá trong khoảng từ minPrice đến maxPrice.
delimiter $$
create procedure filterProductsByPriceRange(in minPrice int, in maxPrice int)
begin
	select * from products where price between minPrice and maxPrice;
end$$
delimiter ;


-- Tạo một procedure tên paginateProducts để phân trang danh sách sản phẩm, với hai tham số pageNumber và pageSize.
delimiter $$
create procedure paginateProducts(in page_size int, in page_number int)
begin
	declare offset_value int;
    set offset_value = page_size * (page_number - 1);
    select * from products
    limit page_size
	offset offset_value;
end$$
delimiter ;


