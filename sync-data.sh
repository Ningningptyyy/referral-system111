#!/bin/bash
# ============================================
# 内推招聘系统 - 数据同步脚本
# 从 Lark Base 多维表格同步岗位数据到 jobs.json
# 使用方式：在 Lark Base 中更新数据后，运行本脚本
# ============================================

BASE_TOKEN="KvPcbMUpeawqelswJl7cyUpDnPf"
TABLE_ID="tblL8ayvBlr0WlHi"

echo "正在从 Lark Base 同步岗位数据..."

# 获取所有记录（只获取已勾选"是否展示"的岗位）
# 字段顺序: 0=岗位名称, 1=岗位介绍, 2=期望城市, 3=是否展示, 4=招聘类型, 5=公司简介, 6=岗位类型
lark-cli base +record-list \
  --base-token "$BASE_TOKEN" \
  --table-id "$TABLE_ID" \
  --as user \
  --format json 2>/dev/null | \
  jq '[.data as $d | $d.data | to_entries[] | select(.value[3] == true) | {
    id: $d.record_id_list[.key],
    name: .value[0],
    description: .value[1],
    city: (.value[2] | if type == "array" then .[0] else . end),
    recruitType: (.value[4] | if type == "array" then .[0] else . end),
    companyIntro: .value[5],
    jobType: (.value[6] | if type == "array" then .[0] else . end)
  }]' > /workspace/referral-site/jobs.json

if [ $? -eq 0 ]; then
  COUNT=$(jq length /workspace/referral-site/jobs.json)
  echo "✓ 同步成功！共同步 $COUNT 个岗位数据"
  echo "  文件路径：/workspace/referral-site/jobs.json"
else
  echo "✗ 同步失败，请检查 Lark Base 是否可访问"
  exit 1
fi