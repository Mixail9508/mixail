-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.


-- делал через терминал, так как не очень понял как сделать через dbeaver
db.shop.insert({category: 'ФРОВ'})
db.shop.insert({category: 'Рыба'})

-- заполнил
db.shop.update({category: 'ФРОВ'}, {$set: { products:['помидоры', 'картофель', 'морковь'] }})
db.shop.update({category: 'Рыба'}, {$set: { products:['минтай', 'семга', 'селдь'] }})