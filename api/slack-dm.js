const SLACK_USER_IDS = {
  'manaar jafri':          'U063AHC7BPH',
  'tanushree hanmattekar': 'U063N5YMAE9',
  'varun kewalramani':     'U08QGN8QB1P',
  'ojus thool':            'U08R01ZL98T',
  'sahil malek':           'U0B4UQAU332',
  'chirag khushalani':     'U08750WBA91',
};

export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const botToken = process.env.SLACK_BOT_TOKEN;
  if (!botToken) return res.status(500).json({ error: 'SLACK_BOT_TOKEN not configured' });

  const { designerNames, taskName, taskStatus, daysInBucket, message } = req.body;
  const results = [];

  for (const name of (designerNames || [])) {
    const userId = SLACK_USER_IDS[(name || '').toLowerCase().trim()];
    if (!userId) { results.push('No Slack ID for: ' + name); continue; }

    const payload = {
      channel: userId,
      blocks: [
        { type: 'section', text: { type: 'mrkdwn', text: '👉 *Poke from Design Radar*' } },
        { type: 'section', text: { type: 'mrkdwn',
          text: 'Hey *' + name + '* — just a nudge about this task:\n\n*' + taskName + '*\n_Status: ' + taskStatus + ' · ' + daysInBucket + ' days in bucket_' } },
        { type: 'section', text: { type: 'mrkdwn', text: message } },
        { type: 'section', text: { type: 'mrkdwn',
          text: ':point_right: <https://designradar-vsl.vercel.app|Open Design Radar> and give it some love.' } },
        { type: 'context', elements: [{ type: 'mrkdwn', text: '_Sent by Chirag via Design Radar_' }] }
      ]
    };

    try {
      const slackRes = await fetch('https://slack.com/api/chat.postMessage', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + botToken,
        },
        body: JSON.stringify(payload),
      });
      const data = await slackRes.json();
      if (data.ok) { results.push('DM sent to ' + name); }
      else { results.push('Slack error for ' + name + ': ' + data.error); }
    } catch (err) {
      results.push('Fetch error for ' + name + ': ' + err.message);
    }
  }

  return res.status(200).json({ ok: true, results });
}
