-- Run this once in Supabase SQL Editor for an existing TENA database.
alter table public.orders alter column table_no drop not null;

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
