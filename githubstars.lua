-- module object
local fetcher = {
  baseURL = 'https://api.github.com/users/mudox/starred',
  itemCountPerPage = 100,
  pageCount = 0,
  errorPages = {},
  successPages = {},
  tmpname = '',
  tmpfile = nil,
  dataFileName = '/Users/mudox/.dotfiles/hammerspoon/data/my_github_stars.json'
}

-- HEAD to get github stars pagination info
function fetcher:fetchStarsPagesInfo()
  local url = ('%s?per_page=%d'):format(self.baseURL, self.itemCountPerPage)

  -- reset status
  self.tmpname = os.tmpname()
  self.tmpfile = io.open(self.tmpname, 'a')
  self.pageCount = 0
  self.itemCountPerPage = 0

  hs.http.doAsyncRequest(url, 'HEAD', nil, nil, function(code, body, headers)
      if code < 0 then
        -- report
        print(string.format('Fetching github stars failed: %s', body))
      else
        -- report
        print 'Fetching github stars succeeded'
        print(string.format('>> Link: %s', headers['Link']))
        local pageCount = headers['Link']:match('[?&]page=(%d+)[^<]-rel="last"')
        local itemCountPerPage = headers['Link']:match('[?&]per_page=(%d+)[^<]-rel="last"')
        local line = ('>> totally %d pages, %d items per page'):format(pageCount, itemCountPerPage)
        print(line)

        -- fetch each pages
        self.itemCountPerPage = tonumber(itemCountPerPage)
        self.pageCount = tonumber(pageCount)

        for i = 1, pageCount do
          self:fetchStarsInPage(i)
        end
      end
  end)
end

function fetcher:fetchStarsInPage(page)
  if page > self.pageCount then
    local line = ('Error: fetch page number (%d) out of bounds (%d)'):format(page, self.pageCount)
    return
  end

  local url = ('%s?per_page=%d&page=%d'):format(self.baseURL, self.itemCountPerPage, page)
  hs.http.asyncGet(url, nil, function (code, body, headers)
      if code < 0 then
        -- report
        print(('Fetching stars in page #%d failed'):format(page))

        table.insert(self.errorPages, page)
        self:checkEnd()
      else
        -- report
        print(('Fetching stars in page #%d succeeded'):format(page))
        print(('>> body length: %d'):format(body:len()))

        -- store partial results
        self.tmpfile:write(body)

        table.insert(self.successPages, page)
        self:checkEnd()
      end
  end)
end

function fetcher:checkEnd()
  if #self.successPages + #self.errorPages == self.pageCount then
    print 'Fetching batch completed'

    if #self.errorPages > 0 then
      print '>> some request failed'

      self.tmpfile:close()
    else
      print '>> congrats'

      self.tmpfile:close()
      os.rename(self.tmpname, self.dataFileName)
    end
  end
end

return fetcher
