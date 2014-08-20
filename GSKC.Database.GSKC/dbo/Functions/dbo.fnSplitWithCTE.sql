CREATE FUNCTION [dbo].[fnSplitWithCTE]
(
   @List VARCHAR(8000),
   @Delimiter CHAR(1),
   @ShowEmpty BIT
)
RETURNS @ret TABLE
(
   Position INT PRIMARY KEY,
   DelimitedValue VARCHAR(8000)
)
AS BEGIN
   DECLARE @LEN INT
   SET @LEN=LEN(@List)+1
 
   ;With a AS
   (
     SELECT 1 AS nStart,
            isNull(NULLIF(CHARINDEX(@Delimiter,@List,1),0),@LEN) AS nEnd,
            RTRIM(LTRIM(SUBSTRING(@List,1,isNull(NULLIF(CHARINDEX(@Delimiter,@List,1),0),@LEN)-1))) AS Value1
     UNION All
     SELECT nEnd+1,
            isNull(NULLIF(CHARINDEX(@Delimiter,@List,nEnd+1),0),@LEN),
            RTRIM(LTRIM(SUBSTRING(@List,nEnd+1,isNull(NULLIF(CHARINDEX(@Delimiter,@List,nEnd+1),0),@LEN)-nEnd-1)))
     FROM a
     WHERE nEnd<@LEN
   )
   INSERT INTO @ret
   SELECT Row_Number() OVER (ORDER BY nStart),
          NULLIF(Value1,'')
    FROM a
    WHERE (@ShowEmpty=1 or LEN(Value1)>0)
    RETURN
END

