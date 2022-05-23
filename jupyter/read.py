def read(fileName):
  data = []
  coordinates = [float('nan')] * 3
  coordComment = re.compile('#\s*x(\d)\s+([0-9\.eE\+\-]+)')
  variables = ''
  p_0 = 0.
  t_s = 0.
  t_d = 0.
  f = open(fileName)
  for row in f:
    row = row.strip()
    if not row[0].isalpha() and not row[0] == '#':
      values = row.split()
      data.append([float(numeric_string) for numeric_string in values])
    elif row[0] == '#':
      match = coordComment.match(row)
      if match:
        coordinates[int(match.group(1))-1] = float(match.group(2))
      elif row[2:5] == 'P_0':
        p_0 = float(row[5:])
      elif row[2:5] == 'T_s':
        t_s = float(row[5:])
      elif row[2:5] == 'T_d':
        t_d = float(row[5:])
    elif row.startswith('VARIABLES'):
      row = row.split('=')
      variables = row[1].replace('"', '').split(',')
      variables = [v.strip() for v in variables]
  f.close()
  if len(data) == 0:
    return None
  if 'P_n' in variables:
    indexP_n = variables.index('P_n')
    data = [d[0:indexP_n] + [d[indexP_n] + p_0] + d[indexP_n+1:] for d in data]
  if 'T_s' in variables:
    indexT_s = variables.index('T_s')
    data = [d[0:indexT_s] + [d[indexT_s] + t_s] + d[indexT_s+1:] for d in data]
  if 'T_d' in variables:
    indexT_d = variables.index('T_d')
    data = [d[0:indexT_d] + [d[indexT_d] + t_d] + d[indexT_d+1:] for d in data]
  return Waveform.Waveform(variables, data, coordinates)
