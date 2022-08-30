local function image(name)
  return hs.image.imageFromPath(HS_CONFIG_DIR .. "/asset/" .. name)
end

return {
  image = image,
}
