-- Run this once in Supabase SQL Editor for an existing TENA database.
alter table public.orders alter column table_no drop not null;

insert into public.menu (name, price, image)
select *
from (values
	('Chechebsa', 150, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=80'),
	('Special Ful', 120, 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80'),
	('Egg Firfir', 140, 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&q=80'),
	('Fetira with Honey', 160, 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=600&q=80'),
	('Ethiopian Tea', 20, 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80'),
	('Coffee', 30, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&q=80')
) as items(name, price, image)
where not exists (select 1 from public.menu);

insert into public.menu (name, price, image)
select 'Bread', 15, 'icon.svg'
where not exists (select 1 from public.menu where lower(name) = 'bread');

insert into public.menu (name, price, image)
select 'Injera', 20, 'icon.svg'
where not exists (select 1 from public.menu where lower(name) = 'injera');

drop policy if exists "Cashiers update own orders" on public.orders;
create policy "Cashiers update own orders" on public.orders for update to authenticated
using (cashier_id = auth.uid())
with check (cashier_id = auth.uid());
