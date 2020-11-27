use ipl;
show tables;

-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
select ibd.*, ibp.no_of_bids, ibp.total_points, (sum(ibd.bid_status='Won')/ibp.no_of_bids)*100 'win_percentage'
from ipl_bidding_details ibd inner join ipl_bidder_points ibp
on ibd.bidder_id=ibp.bidder_id
group by ibd.bidder_id
order by win_percentage desc;

-- 2.	Which teams have got the highest and the lowest no. of bids?
select it.*, count(ibd.bid_team) 'no_of_bids'
from ipl_bidding_details ibd inner join ipl_team it
on 	it.team_id=ibd.bid_team
group by it.team_id
order by no_of_bids desc;
/*
Highest number of bids = Sunrisers Hyderabad
Lowest number of bids =  Chennai Super Kings, Mumbai Indians, Kolkata Knight Riders 
*/

-- 3.	In a given stadium, what is the percentage of wins by a team which had won the toss?
create view toss as
select ipls.stadium_name, ipls.stadium_id, count(im.toss_winner) 'ab'
from ipl_stadium ipls inner join ipl_match_schedule ims
on ipls.stadium_id=ims.stadium_id
inner join ipl_match im
on im.match_id=ims.match_id
where im.toss_winner=im.match_winner
group by stadium_name;
select toss.stadium_name, toss.stadium_id,(ab/count(ims.stadium_id))*100 'win percent when a team won the toss'
from toss inner join ipl_match_schedule ims
on toss.stadium_id=ims.stadium_id
group by toss.stadium_name;

-- 4.	What is the total no. of bids placed on the team that has won highest no. of matches?
create view bids as
select *,
case
when  match_winner=1 then team_id1
when match_winner=2 then team_id2
end 'winning_team'
from ipl_match;

select *, count(bid_team) 'total_no_of_bids' from ipl_bidding_details
group by bid_team
having bid_team=(
select winning_team from bids
group by winning_team
order by count(winning_team) desc 
limit 1);
/* team_id 6 won the highest number of matches & total no. of bids placed on them was 27 */

-- 5.	From the current team standings, if a bidder places a bid on which of the teams, there is a possibility 
-- of (s)he winning the highest no. of points – in simple words, identify the team which has the highest jump in its 
-- total points (in terms of percentage) from the previous year to current year.
create view points2017 as
select tournmt_id, total_points, team_id from ipl_team_standings where tournmt_id=2017;
create view points2018 as
select tournmt_id, total_points, team_id from ipl_team_standings where tournmt_id=2018;
select a.team_id, ((b.total_points-a.total_points)/a.total_points)*100 'jump_percent'
from points2017 a inner join points2018 b
on a.team_id=b.team_id
order by jump_percent desc
limit 1;
/* team_id= 6 made the highest jump in its total points (in terms of percentage) from previous year to this year */
