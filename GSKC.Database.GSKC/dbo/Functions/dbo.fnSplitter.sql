CREATE Function [dbo].[fnSplitter] (@List Varchar(200) )  
Returns @Tbl_IDs Table  (Item VARCHAR(200))  As  

Begin 
 -- Append comma
 SET @List = Replace(@List, ' and ',',')
 Set @List =  @List + ',' 
 -- Indexes to keep the position of searching
 Declare @Pos1 Int
 Declare @pos2 Int
 
 -- Start from first character 
 Set @Pos1=1
 Set @Pos2=1

 While @Pos1<Len(@List)
 Begin
  Set @Pos1 = CharIndex(',',@List,@Pos1)
  Insert @Tbl_IDs Select  Cast(Substring(@List,@Pos2,@Pos1-@Pos2) As VARCHAR(200))
  -- Go to next non comma character
  Set @Pos2=@Pos1+1
  -- Search from the next charcater
  Set @Pos1 = @Pos1+1
 End 
 Return
End